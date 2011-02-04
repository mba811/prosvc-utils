Puppet::Parser::Functions::newfunction(:create_resources_of_type, :doc => '
Converts a hash into resources and adds them to the catalog.
Takes two parameters:
  accepts($type, $resources)
Creates resources of type $type from the $resources hash. Assumes that hash is in the following form:
  {title=>{attr=>value}}
') do |args|
  raise ArgumentError, 'requires resource type and hash' unless args.size == 2
  args[1].each do |title, params|
    # eventaully, I would like another argument that specifies constraints
    raise ArgumentError, 'params should not contain title' if params['title']
    resource = Puppet::Type.type(args[0].to_sym).hash2resource(params.merge(:title => title))
    catalog.add_resource(resource)
  end
end
