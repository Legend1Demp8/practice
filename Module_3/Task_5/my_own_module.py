#!/usr/bin/python

# Copyright: (c) 2026, Your Name <your.email@example.org>
# GNU General Public License v3.0+ (see COPYING or https://gnu.org)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_own_module

short_description: Create a text file with specified content

version_added: "1.0.0"

description:
    - This module creates a text file on the remote host at the specified path with the given content.

options:
    path:
        description: Path to the file to be created on the remote host.
        required: true
        type: str
    content:
        description: Content to write into the file.
        required: true
        type: str

author:
    - Your Name (@yourGitHubHandle)
'''

EXAMPLES = r'''
- name: Create a file with content
  my_own_module:
    path: /tmp/testfile.txt
    content: "Hello, world!"
'''

RETURN = r'''
message:
    description: Status message about file creation or update.
    type: str
    returned: always
    sample: 'File created/updated successfully'
'''

import os
from ansible.module_utils.basic import AnsibleModule


def run_module():
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True)
    )

    result = dict(
        changed=False,
        message=''
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    path = module.params['path']
    content = module.params['content']

    file_exists = os.path.exists(path)
    needs_write = True

    if file_exists:
        try:
            with open(path, 'r', encoding='utf-8') as f:
                current_content = f.read()
            if current_content == content:
                needs_write = False
                result['message'] = 'File already exists with the same content'
        except Exception as e:
            module.fail_json(msg=f'Failed to read existing file: {str(e)}', **result)

    if needs_write:
        result['changed'] = True
        if module.check_mode:
            result['message'] = 'File would be created/updated'
            module.exit_json(**result)

        try:
            parent_dir = os.path.dirname(path)
            if parent_dir and not os.path.exists(parent_dir):
                os.makedirs(parent_dir)

            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
            result['message'] = 'File created/updated successfully'
        except Exception as e:
            module.fail_json(msg=f'Failed to write file: {str(e)}', **result)

    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
