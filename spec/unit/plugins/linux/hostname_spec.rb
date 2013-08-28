#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper.rb')

describe Ohai::System, "Linux hostname plugin" do
  before(:each) do
    @plugin = get_plugin("linux/hostname")
    @plugin[:os] = "linux"
  end

  describe "when the hostname is an FQDN" do
    before(:each) do
      @plugin.stub(:from).with("hostname").and_return("katie.bethell")
      @plugin.stub(:from).with("hostname -s").and_return("katie")
    end

    describe "when hostname -f resolves" do
      before(:each) do
        @plugin.stub(:from).with("hostname --fqdn").and_return("katie.bethell")
      end
      it "should not raise an error" do
        lambda { @plugin.run }.should_not raise_error
      end
      it "should set fqdn to the result of hostname -f" do
        @plugin.run
        @plugin.fqdn.should == "katie.bethell"
      end
      it "should set fqdn to the long name" do
        @plugin.run
        @plugin.fqdn.should == "katie.bethell"
      end
    end

    describe "when hostname -f raises an error" do
      before(:each) do
        @plugin.stub(:from).with("hostname --fqdn").and_raise("Ohai::Exception::Exec")
      end
      it "should not raise an error" do
        lambda { @plugin.run }.should_not raise_error
      end
    end
  end

  describe "when the hostname is short" do
    before(:each) do
      @plugin.stub(:from).with("hostname").and_return("katie")
      @plugin.stub(:from).with("hostname -s").and_return("katie")
    end
    describe "when hostname -f resolves" do
      before(:each) do
        @plugin.stub(:from).with("hostname --fqdn").and_return("katie.bethell")
      end
      it "should not raise an error" do
        lambda { @plugin.run }.should_not raise_error
      end
      it "should set fqdn to the result of hostname -f" do
        @plugin.run
        @plugin.fqdn.should == "katie.bethell"
      end
    end

    describe "when hostname -f raises an error" do
      before(:each) do
        @plugin.stub(:from).with("hostname --fqdn").and_raise("Ohai::Exception::Exec")
      end
      it "should not raise an error" do
        lambda { @plugin.run }.should_not raise_error
      end
      it "should set fqdn to the short name" do
        @plugin.run
        @plugin.fqdn.should == "katie"
      end
    end
  end

end

