
lines = File.readlines('preserve.txt').map { |i| i.gsub(/\n/,"") }
leaves = `brew leaves`.split("\n")
# puts lines.inspect
# puts leaves.inspect

to_remove = leaves - lines

to_remove.each { |x| puts "removing #{x}"; `brew uninstall -f #{x}` }
