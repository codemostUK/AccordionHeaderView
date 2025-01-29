Pod::Spec.new do |s|
  s.name             = 'AccordionHeaderView'
  s.module_name      = 'AccordionHeaderView'
  s.version          = '1.0.4'
  s.license          = { :type => 'Copyright', :text => <<-LICENSE
									Copyright 2024
									Codemost Limited. 
									LICENSE
								}
  s.homepage         = 'http://www.codemost.co.uk/'
  s.author           = { 'Codemost Limited' => 'tolga@codemost.co.uk' }
  s.summary          = 'A UIPageViewController-based project that integrates an accordion-style header view with scrollable pages.'
  s.description     = <<-DESC
                        AccordionHeaderView is a Swift library that enhances UIPageViewController by integrating an expandable accordion-style header view. It dynamically adjusts its height based on user scrolling behavior, ensuring a smooth and intuitive navigation experience. The project includes a fully functional example demonstrating how to embed and customize the accordion header within a multi-page scrolling interface.
                       DESC

  s.source           = { :git => 'https://github.com/codemostUK/AccordionHeaderView.git',
 								 :tag => s.version.to_s }
  s.source_files     = 'AccordionHeaderView/*.{swift}'
  s.documentation_url = 'https://github.com/codemostUK/AccordionHeaderView/blob/main/README.md'
  s.requires_arc    = true
  s.ios.deployment_target = '13.0'
  s.swift_version   = '5.5'
  s.frameworks = 'UIKit', 'Foundation'
end
