Role Name
=========

This is one of the ansible role which tests ansible different variable types
and their precedence

Precedence:
command > playbook > role-var > host-var > group-var > global var

Example: Create variable with any name which is same throughout your all above
directory and see using register & debug module for the output change.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - var_test

License
-------

BSD

Author Information
------------------

https://github.com/punit144?tab=repositories
