
require "minitest/autorun"

require "./lib/tftpfilesender"

EV = EventMachine


class DummyReader

  FILES = {
    "small" => "small content",
    "larger" => "X"*600,
    "mod512" => "X"*512*4
  }

  def read(name)
    FILES[name]
  end

end

class DummyFileSender < TFTP::FileSender

  attr_reader :sent_packets

  def initialize(&callback)
    super("127.0.0.1", 1234, DummyReader.new())
    @sent_packets = []
  end

  def send_datagram(*args)
    @sent_packets.push args
  end

end

describe TFTP::FileSender do


  it "sends small file in one package" do
    EV::run do
      sender = DummyFileSender.new nil
      sender.on_data do |data, ip, port|
          assert_equal(
            data,
            "\x00\x03\x00\x01small content"
          )
        EV::stop_event_loop
      end

      sender.handle_get([
        TFTP::Opcode::RRQ,
        "small",
        "octet"
      ].pack("na*xa*x"))
    end
  end

  it "sends larger file in two packages" do
    EV::run do
      sender = DummyFileSender.new nil

      sender.on_data do |data, ip, port|
        _, num = data.unpack("nn")
        puts "GOT #{ data.inspect }"

        # sender.handle_ack([
        #   TFTP::Opcode::ACK,
        #   num
        # ].pack("nn"))
      end

      sender.on_end do
        # assert_equal(
        #   "\x00\x03\x00\x01" + "X"*512,
        #   sender.sent_packets[0][0]
        # )

        # assert_equal(
        #   "\x00\x03\x00\x02" + "X"*(600-512),
        #   sender.sent_packets[1][0]
        # )

        EV::stop_event_loop
      end

      sender.handle_get([
        TFTP::Opcode::RRQ,
        "larger",
        "octet"
      ].pack("na*xa*x"))

    end
  end

  # it "sends an empty packge after sending mod 512 file" do
  #   EV::run do

  #     sender = DummyFileSender.new nil do |*args|
  #       puts "PACAGE #{ args.inspect }"
  #     end

  #     sender.handle_get([
  #       TFTP::Opcode::RRQ,
  #       "mod512",
  #       "octet"
  #     ].pack("na*xa*x"))

  #     sender.handle_ack([
  #       TFTP::Opcode::ACK,
  #       1
  #     ].pack("nn"))

  #     assert_equal(
  #       "\x00\x03\x00\x02" + "X"*(600-512),
  #       sender.sent_packets[1][0]
  #     )

  #     EV::stop_event_loop
  #   end
  # end

end

