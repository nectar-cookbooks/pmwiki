node.default['pmwiki']['version'] = 'pmwiki-latest' # any version sans the '.zip' suffix
node.default['pmwiki']['action'] = 'install' # or 'upgrade'
node.default['pmwiki']['config'] = 'simple' # or 'sample'
node.default['pmwiki']['auto_config'] = false
node.default['pmwiki']['config_cookbook'] = nil

node.default['pmwiki']['wiki_title'] = 'Default Wiki Title'
node.default['pmwiki']['page_logo_url'] = nil
node.default['pmwiki']['script_url'] = nil 
node.default['pmwiki']['pub_dir_url'] = nil

# The password attributes should be set to hashes that are compatible
# with the PHP 'crypt' function.  If the password attributes are not 
# set, we use an annoyingly long and hard to type passwords ... to 
# encourage the you to do the right thing and set the password. 
node.default['pmwiki']['admin_password'] = nil
node.default['pmwiki']['upload_password'] = nil

node.default['pmwiki']['enable_upload'] = false
node.default['pmwiki']['upload_perm_add'] = 0
node.default['pmwiki']['enable_path_info'] = false
node.default['pmwiki']['enable_diag'] = false
node.default['pmwiki']['enable_ims_caching'] = false
node.default['pmwiki']['enable_creole'] = false
node.default['pmwiki']['enable_wikiwords'] = false
node.default['pmwiki']['space_wikiwords'] = false
node.default['pmwiki']['tz'] = 'UTC'      # This must be set ...
node.default['pmwiki']['blocklist'] = nil # e.g. 1 or 10 -
                                                  # see PmWiki.Blocklist
node.default['pmwiki']['ws_pre'] = 0
node.default['pmwiki']['diff_keep_days'] = nil
node.default['pmwiki']['enable_page_list_protect'] = true
node.default['pmwiki']['enable_refcount'] = false
node.default['pmwiki']['enable_atom_feed'] = false # Atom 1.0
node.default['pmwiki']['enable_rss_feed'] = false  # RSS 2.0
node.default['pmwiki']['enable_dc_feed'] = false   # Dublin Core
node.default['pmwiki']['enable_rdf_feed'] = false  # RSS 1.0
node.default['pmwiki']['enable_relative_page_vars'] = false
node.default['pmwiki']['enable_autocreate_categories'] = false
node.default['pmwiki']['skin'] = nil
node.default['pmwiki']['enable_post_author_required'] = true

# Supported alternatives are 'swf.php', 'flash.php' and 'flash2.php'; see
# http://www.pmwiki.org/wiki/Cookbook/Flash for defails.
node.default['pmwiki']['flash_script'] = 'swf.php'

node.default['pmwiki']['geshi_version'] = '1.0.8.11'
