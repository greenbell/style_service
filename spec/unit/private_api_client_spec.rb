# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe StyleService::PrivateAPI::Client do
  before do
    @options = {
      :key    => '5xWGC9u+d/+sjS80cSO//yc22MS1S6W26x3q2MMHslg=',
      :secret => 'zpxICM9P2xZ0gZL4RjmWMwHghEVNGmwMbeSZs8Cfyhs=',
      :host   => 'pri.api.my.style-vip.jp'
    }
  end

  context "initialize" do
    it "should not init because application key is blank" do
      @options.delete(:key)
      lambda { StyleService::PrivateAPI::Client.new(@options) }.should raise_error( ArgumentError )
    end

    it "should not init because secret token is blank" do
      @options.delete(:secret)
      lambda { StyleService::PrivateAPI::Client.new(@options) }.should raise_error( ArgumentError )
    end

    it "should not init because host is blank" do
      @options.delete(:host)
      lambda { StyleService::PrivateAPI::Client.new(@options) }.should raise_error( ArgumentError )
    end

    it "should be default port 80" do
      StyleService::PrivateAPI::Client.new(@options).port.should eql 80
    end

    it "should be able to specify any port" do
      @options[:port] = 8080
      StyleService::PrivateAPI::Client.new(@options).port.should eql 8080
    end

    context "when ssl option effective" do
      it "should be port 443" do
        @options[:ssl] = true
        StyleService::PrivateAPI::Client.new(@options).port.should eql 443
      end
    end
  end
end
