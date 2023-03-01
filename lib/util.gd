extends Node

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
	path = path.trim_suffix('/')
	return path.substr(path.rfind('/') + 1)

func get_username() -> String:
	if OS.has_environment('USER'):
		return OS.get_environment('USER')
	else:
		return ''
