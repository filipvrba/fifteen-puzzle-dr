require 'lib/core.rb'
require 'lib/fifteen.rb'

require "app/scenes.rb"
require 'app/objects.rb'

def tick args
  args.state.scene_root ||= Scenes::Root.new
  args.state.scene_root.tick(args)
end