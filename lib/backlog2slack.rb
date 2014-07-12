Dir.glob(File.join(File.dirname(__FILE__), '/backlog2slack/**/*.rb')) do |f|
  require f.sub(/\.rb/, '')
end
