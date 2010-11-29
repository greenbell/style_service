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

  context "when request method is GET" do
    before do
      @client = StyleService::PrivateAPI::Client.new(@options)
      @path   = "/users/1.json"
      @uri    = "http://#{@options[:host]}#{@path}" 
    end

    it "should demand argument" do
      lambda { @client.get }.should raise_error( ArgumentError )
    end

    context "when 200 ok" do
      before do
        WebMock.stub_request(:get, @uri).to_return(:status => 200, :body => {}.to_json)
        @response = @client.get(@path)
      end

      subject { @response }

      it { should be_instance_of StyleService::PrivateAPI::Response }
      it { should be_respond_to :header }
      it { should be_respond_to :body }
      its(:header) { should be_instance_of Net::HTTPOK }
      its(:body)   { should be_instance_of Hash }
    end

    context "when 404 error" do
      before do
        WebMock.stub_request(:get, @uri).to_return(:status => 404, :body => 'Not Found')
        @response = @client.get(@path)
      end

      subject { @response }

      it { should be_instance_of StyleService::PrivateAPI::Response }
      it { should be_respond_to :header }
      it { should be_respond_to :body }
      its(:header) { should be_instance_of Net::HTTPNotFound }
      its(:body)   { should be_instance_of String }
      its(:body)   { should eql "Not Found" }
    end
  end

  context "when request method is POST" do
    before do
      @client = StyleService::PrivateAPI::Client.new(@options)
      @path   = "/users"
      @uri    = "http://#{@options[:host]}#{@path}" 
    end

    it "should demand argument" do
      lambda { @client.post }.should raise_error( ArgumentError )
    end

    context "when 201 created" do
      before do
        WebMock.stub_request(:post, @uri).with(:body => {:nickname => "nick"}).to_return(:status => 201, :body => {:nickname => "nick"}.to_json)
        @response = @client.post(@path, {:nickname => "nick"})
      end

      subject { @response }

      it { should be_instance_of StyleService::PrivateAPI::Response }
      it { should be_respond_to :header }
      it { should be_respond_to :body }
      its(:header) { should be_instance_of Net::HTTPCreated }
      its(:body)   { should be_instance_of Hash }
    end
  end

  context "when request method is PUT" do
    before do
      @client = StyleService::PrivateAPI::Client.new(@options)
      @path   = "/users/1.json"
      @uri    = "http://#{@options[:host]}#{@path}" 
    end

    it "should demand argument" do
      lambda { @client.put }.should raise_error( ArgumentError )
    end

    context "when 200 ok" do
      before do
        WebMock.stub_request(:post, @uri).with(:body => {:nickname => "nick", :_method => "put"}).to_return(:status => 200)
        @response = @client.put(@path, {:nickname => "nick"})
      end

      subject { @response }

      it { should be_instance_of StyleService::PrivateAPI::Response }
      it { should be_respond_to :header }
      it { should be_respond_to :body }
      its(:header) { should be_instance_of Net::HTTPOK }
    end
  end

  context "when request method is PUT" do
    before do
      @client = StyleService::PrivateAPI::Client.new(@options)
      @path   = "/users/1.json"
      @uri    = "http://#{@options[:host]}#{@path}" 
    end

    it "should demand argument" do
      lambda { @client.delete }.should raise_error( ArgumentError )
    end

    context "when 200 ok" do
      before do
        WebMock.stub_request(:post, @uri).with(:body => {:_method => "delete"}).to_return(:status => 200)
        @response = @client.delete(@path)
      end

      subject { @response }

      it { should be_instance_of StyleService::PrivateAPI::Response }
      it { should be_respond_to :header }
      it { should be_respond_to :body }
      its(:header) { should be_instance_of Net::HTTPOK }
    end
  end
end
