Role Name
=========

this project covers all the basics and advanced features of ansible.

Requirements
------------

python 2.x, python 3.x, virtual-box or vmware workstation or fusion
ansible 2.9 downloaded from EPEL library
master ansible server
2-3 host nodes for testing features.

License
-------

NA

Author Information
------------------

Author: Punit Grewal
# Project-Ansible
.
├── ansible.cfg
├── basics_playbooks
├── files
├── group_vars
│   ├── all.yml
│   ├── Production.yml
│   └── Testing.yml
├── host_vars
│   ├── bkup
│   │   ├── oracle7-n01.yml
│   │   ├── oracle7-n02.yml
│   │   ├── oracle8-n01.yml
│   │   └── oracle8-n02.yml
│   ├── oracle7-n01.yml
│   ├── oracle7-n02.yml
│   ├── oracle8-n01.yml
│   └── oracle8-n02.yml
├── inventory
├── library
├── module_utils
├── README.md
├── roles
│   ├── update
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   └── var_test
│       ├── defaults
│       │   └── main.yml
│       ├── files
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── README.md
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       ├── tests
│       │   ├── inventory
│       │   └── test.yml
│       └── vars
│           └── main.yml
├── site.yml
└── templates
