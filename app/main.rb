require 'lib/core-1.0.0/core.rb'
require 'lib/fifteen-1.0.0/fifteen.rb'

require "app/scenes.rb"
require 'app/objects.rb'

def tick args
  args.state.scene_root ||= Scenes::Root.new
  args.state.scene_root.tick(args)
end