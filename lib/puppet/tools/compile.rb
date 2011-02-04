require 'puppet'
require 'puppet/external/pson/common'
require 'puppet/tools/catalog'
#
# I am storing all of the compiler related functionality here that 
# I created in order to create the puppet test application.
#
module Puppet::Tools
  module Compile
    include PSON
    include Puppet::Tools::Catalog
  
    # iterate though all of the facts in yamldir and use them
    # to compile catalogs from nodes
    def get_all_nodes(type, yamldir=Puppet[:yamldir], format='yaml')
      match_nodes('*', type, yamldir, format)
    end

    def match_nodes(match, type, yamldir=Puppet[:yamldir], format='yaml')
      Dir[File.join(yamldir, "#{type}/#{match}.#{format}")].collect do |fn| 
        node_name = File.basename(fn, ".#{format}")
      end
    end

    def write_catalog(catalog, filename)
      File.open(filename, "w") { |catalog|
        #puts "writing #{outputdir}/#{node.name}"
        catalog.write(catalog)
      }
      Puppet.notice("wrote catalog for #{node.name} to #{outputdir}")
    end
  end
end
