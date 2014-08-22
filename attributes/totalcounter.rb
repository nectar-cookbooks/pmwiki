node['pmwiki']['totalcounter']['action'] = null     # default 'totalcounter'
node['pmwiki']['totalcounter']['auth_level'] = null # default 'admin'
node['pmwiki']['totalcounter']['max_items'] = null  # default 20
node['pmwiki']['totalcounter']['enable_lookup'] = false
node['pmwiki']['totalcounter']['bar_color'] = null  # default '#5af'
node['pmwiki']['totalcounter']['show_numbers'] = true

# Each of these is an array of plain strings or PHP regexes, e.g.
#     ['Admin', 'Paul', '/^Author.*/'] 
node['pmwiki']['totalcounter']['blacklist']['Pages'] = []
node['pmwiki']['totalcounter']['blacklist']['Users'] = []
node['pmwiki']['totalcounter']['blacklist']['Browsers'] = []
node['pmwiki']['totalcounter']['blacklist']['OSes'] = []
node['pmwiki']['totalcounter']['blacklist']['Referers'] = []
node['pmwiki']['totalcounter']['blacklist']['Locations'] = []
node['pmwiki']['totalcounter']['blacklist']['Bots'] = []
node['pmwiki']['totalcounter']['blacklist']['Languages'] = []
