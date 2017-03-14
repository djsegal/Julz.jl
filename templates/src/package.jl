
  using Julz

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end
  src_folder = "$(pwd())/src"

  Julz.include_all_files(src_folder)
  Julz.@export_all_files src_folder
