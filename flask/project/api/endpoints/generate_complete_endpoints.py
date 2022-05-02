import json
import pathlib

version_list = ["v0"]
group_list = ["structure"]

result = {}
result['versions'] = []

for version in version_list:
    print("Adding version: "+ version)
    result[version] = {}
    result[version]['title'] = version
    result[version]["endpoints"] = []
    
    for group in group_list:
        with open(str(pathlib.Path(__file__).parent.resolve())+'/'+ version +'/'+ group +'/endpoints.json') as group_json_file:
                endpoint = json.load(group_json_file)
                print("- Adding group: "+ endpoint["title"]+ " from "+ group)
                result[version]["endpoints"].append(endpoint)
                
    with open(str(pathlib.Path(__file__).parent.resolve())+'/'+ version +'/endpoints.json', 'w') as outfile:
        print("Saving version the file")
        version = result[version]
        json.dump(version, outfile , indent=4)


with open(str(pathlib.Path(__file__).parent.resolve())+'/endpoints.json', 'w') as outfile:
    print("Saving into the file")
    json.dump(result, outfile , indent=4)