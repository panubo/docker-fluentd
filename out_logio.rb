# From https://github.com/black-roland/fluent-plugin-logio/blob/fddb71a71d4d1b93d6202ab0db3ee71fabf91650/lib/fluent/plugin/out_logio.rb
# The MIT License (MIT) Copyright (c) 2016 Black Roland (https://github.com/black-roland)
# The MIT License (MIT) Copyright (c) 2017 Volt Grid Pty Ltd

require 'fluent/output'
require 'socket'

module Fluent
  class LogioOutput < Output

    Fluent::Plugin.register_output('logio', self)

    config_param :output_type, :default => 'json'
    config_param :host, :string, :default => 'localhost'
    config_param :port, :integer, :default => 28777
    config_param :node, :string, :default => nil
    config_param :stream, :string, :default => nil
    config_param :log_level, :string, :default => 'info'
    config_param :node_key_name, :string, :default => 'hostname'
    config_param :stream_key_name, :string, :default => nil
    config_param :log_level_key_name, :string, :default => nil

    def configure(conf)
      super

      @formatter = Plugin.new_formatter(@output_type)
      @formatter.configure(conf)
    end

    def start
      super
      puts @host
      puts @port
      @socket = TCPSocket.open(@host, @port)
    end

    def shutdown
      super

      @socket.close
    end

    def emit(tag, es, chain)
      es.each do |time,record|
        stream = @stream ? @stream : tag
        node = @node ? @node : Socket.gethostname
        logLevel = @log_level
        record_flat = flatten_hash(record)

        stream = (record_flat[@stream_key_name] or stream) if @stream_key_name
        node = (record_flat[@node_key_name] or node) if @node_key_name
        logLevel = (record_flat[@log_level_key_name] or logLevel) if @log_level_key_name

        @socket.puts "+log|#{stream}|#{node}|#{logLevel}|#{@formatter.format(tag, time, record).chomp}\r\n"
      end

      chain.next
    rescue => e
      log.error "emit", :error_class => e.class, :error => e.to_s
      log.error_backtrace
    end

    # From http://stackoverflow.com/a/23521624/3863307
    def flatten_hash(hash)
      hash.each_with_object({}) do |(k, v), h|
        if v.is_a? Hash
          flatten_hash(v).map do |h_k, h_v|
            h["#{k}.#{h_k}"] = h_v
          end
        else 
          h[k] = v
        end
       end
    end

  end
end
