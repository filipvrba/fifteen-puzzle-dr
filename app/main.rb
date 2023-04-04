require 'lib/pp.rb'
require 'lib/core-1.0.1/core.rb'
require 'lib/core-1.0.1/objects.rb'
require 'lib/core-1.0.1/structures.rb'
require 'lib/fifteen-1.0.0/fifteen.rb'

require "app/scenes.rb"
require 'app/objects.rb'
require 'app/components.rb'
require 'app/animations.rb'

def tick args
  args.state.scene_root ||= Scenes::Root.new
  args.state.scene_root.tick(args)
end