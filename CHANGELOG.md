# Ohai Changelog

## Unreleased: 7.0.2

* Skip v7 plugins when refreshing a v6 plugin. Fixes
  `Ohai::Exceptions::AttributeNotFound` errors in Chef's ohai resource
* Added platform_family support for ibm_powerkvm (OHAI-558)
* EC2 metadata errors are unhelpful (OHAI-566)
* Support deep virtualization systems in node[:virtualization][:systems] (OHAI-182)

## Last Release: 7.0.0 (04/01/2014)

http://www.getchef.com/blog/2014/04/08/release-chef-client-11-12-0-10-32-2/
