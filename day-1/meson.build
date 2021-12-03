project('day-1', 'vala', 'c')

exe_names = [
  'part-1',
  'part-2',
]

vala_flags = [
  '--enable-checking',
  '--nostdpkg',
]

valac = meson.get_compiler('vala')

day_1_deps = [
  dependency('glib-2.0', version : '>=2.50'),
  dependency('gobject-2.0', version : '>=2.50'),
  valac.find_library('posix'),
]

foreach exe_name : exe_names
  executable(
    exe_name,
    exe_name + '.vala',

    dependencies : day_1_deps,
    vala_args    : vala_flags,
  )
endforeach
