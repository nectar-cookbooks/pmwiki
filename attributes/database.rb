node.default['pmwiki']['adodb']['version'] = '519'
node.default['pmwiki']['adodb']['default_password'] = nil
node.default['pmwiki']['adodb']['databases'] = {}

# Example 'databases' hash.  Note that other recipes may add their own
# entries to the attribute on the fly.
# { 
#   'myUserDatabase' => {
#     'driver' => 'mysqli',
#     'hostname' => 'localhost',
#     'database' => 'pmwikiDatabase',
#     'username' => 'pmwikiUser',
#     'password' => nil
#   }
# }                                           
