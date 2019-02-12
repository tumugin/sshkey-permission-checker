require 'etc'

class String
  def black
    "\e[30m#{self}\e[0m"
  end

  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

  def brown
    "\e[33m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end

  def magenta
    "\e[35m#{self}\e[0m"
  end

  def cyan
    "\e[36m#{self}\e[0m"
  end

  def gray
    "\e[37m#{self}\e[0m"
  end

  def bg_black
    "\e[40m#{self}\e[0m"
  end

  def bg_red
    "\e[41m#{self}\e[0m"
  end

  def bg_green
    "\e[42m#{self}\e[0m"
  end

  def bg_brown
    "\e[43m#{self}\e[0m"
  end

  def bg_blue
    "\e[44m#{self}\e[0m"
  end

  def bg_magenta
    "\e[45m#{self}\e[0m"
  end

  def bg_cyan
    "\e[46m#{self}\e[0m"
  end

  def bg_gray
    "\e[47m#{self}\e[0m"
  end

  def bold
    "\e[1m#{self}\e[22m"
  end

  def italic
    "\e[3m#{self}\e[23m"
  end

  def underline
    "\e[4m#{self}\e[24m"
  end

  def blink
    "\e[5m#{self}\e[25m"
  end

  def reverse_color
    "\e[7m#{self}\e[27m"
  end
end

if ARGV[0].nil?
  puts 'Usage: sshkey-permission-checker [USERNAME]'
  puts '[USERNAME] Test target user name.'
  exit
end

user_uid = Etc.getpwnam(ARGV[0]).uid
user_home = Etc.getpwnam(ARGV[0]).dir

dotssh_stat = File.stat("#{user_home}/.ssh")
dotssh_permisson_str = (dotssh_stat.mode & 0o7777).to_s(8)
dotssh_uid = dotssh_stat.uid
puts 'Checking ~/.ssh permission and owner...'.bold
puts ">>> is .ssh owned by user #{ARGV[0]} => #{user_uid == dotssh_uid ? '[OK]'.green : '[NG]'.red}"
puts ">>> is .ssh permission is 700 => #{dotssh_permisson_str == '700' ? '[OK]'.green : '[NG]'.red}"
puts ''

if File.exist?("#{user_home}/.ssh/authorized_keys")
  authorizedkeys_stat = File.stat("#{user_home}/.ssh/authorized_keys")
  authorizedkeys_permisson_str = (authorizedkeys_stat.mode & 0o7777).to_s(8)
  authorizedkeys_uid = authorizedkeys_stat.uid
  puts 'Checking ~/.ssh/authorized_keys permission and owner...'.bold
  puts ">>> is .ssh owned by user #{ARGV[0]} => #{user_uid == authorizedkeys_uid ? '[OK]'.green : '[NG]'.red}"
  puts ">>> is .ssh permission is 600 => #{authorizedkeys_permisson_str == '600' ? '[OK]'.green : '[NG]'.red}"
else
  puts '~/.ssh/authorized_keys does not exists... skipping'.bold
end
puts ''

puts 'Checking for ~/.ssh/id_* files...'.bold
Dir["#{user_home}/.ssh/id_*"].reject {|f| f.end_with?('.pub')}.each do |filename|
  key_stat = File.stat(filename)
  key_permission_str = (key_stat.mode & 0o7777).to_s(8)
  key_uid = key_stat.uid
  puts ">>Checking #{filename} permission and owner...".bold
  puts ">>> is #{filename} owned by user #{ARGV[0]} => #{user_uid == key_uid ? '[OK]'.green : '[NG]'.red}"
  puts ">>> is #{filename} permission is 600 => #{key_permission_str == '600' ? '[OK]'.green : '[NG]'.red}"
  puts ''
end