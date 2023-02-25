extends Node

var directory := Directory.new()

func get_subdirectories(path: String) -> Array:
	var lst  := []
	var dir  := Directory.new()
	var file := ''
	
	dir.open(path)
	dir.list_dir_begin(true, true)
	file = dir.get_next()
	while '' != file:
		if dir.current_is_dir():
			lst.append(file)
		file = dir.get_next()
	return lst

func translate_path_name(path: String) -> String:
	var username := get_username()
	var home     := '/home/' + username
	match path:
		'/':  return 'Root'
		home: return 'Home'
		_:    return get_relative_path(path)

func get_absolute_path(dir: Directory, path: String) -> String:
	if path.is_rel_path():
		return dir.get_current_dir().trim_suffix('/') + '/' + path
	else:
		return path

func get_relative_path(path: String) -> String:
	path = path.get_basename().trim_suffix('/')
	return path.substr(path.rfind('/') + 1)

func get_username() -> String:
	if OS.has_environment('USER'):
		return OS.get_environment('USER')
	else:
		return ''
