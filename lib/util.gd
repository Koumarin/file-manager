extends Node

func get_subdirectories(path: String) -> Array[String]:
	var lst:  Array[String]
	var dir:  DirAccess
	var file: String
	
	dir = DirAccess.open(path)
	dir.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
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

func get_absolute_path(dir: DirAccess, path: String) -> String:
	if path.is_relative_path():
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
