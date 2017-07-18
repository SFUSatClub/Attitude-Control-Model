# Configuration File
All model configuration can be defined in an .ini file. [Model] and [Orbit] sections are required. Additional section can be added for defining spacecraft properties, mission properties, etc. The path to the configuration file is passed to the Model_Executor. Properties can be assed by:
'''
ini = IniConfig();
ini.ReadFile(Spacecraft_Config);
ini.GetValues(Section Name, Key Name)
'''
and the config file has the format:
'''
[Section Name]
Key Name = value
Key Name = value

[Section Name]
Key Name = value
'''
.