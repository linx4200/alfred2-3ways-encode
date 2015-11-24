#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require './bundle/bundler/setup'
require 'alfred'

class Encode
  def md5(str)
    d5 = Digest::MD5.new
    md5.update str
    md5.hexdigest
  end
end

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  if ARGV.length === 2
    type = ARGV[0]
    puts type
  end

  # if ARGV.length == 0
  #   # now = gen_now_t
  #   # fb.add_item(title: now[:second], subtitle: '10位秒级别时间戳')
  #   # fb.add_item(title: now[:millisecond], subtitle: '13位毫秒级别时间戳')
  # end

  # if ARGV[0] && (ARGV[0].length === 10 || ARGV[0].length === 13)
  #   args = ARGV[0];
  #   time = date_formate(parse_time_stamp(args.to_s))
  #   fb.add_item(title: time, subtitle: '解析时间戳')
  # end

  puts fb.to_alfred
end
