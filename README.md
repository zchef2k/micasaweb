1. Build the container or pull it from this repo's releases
```podman build -t micasaweb .```
2. Run the container
```podman run -d -p 7681:7681 -v /<some path>/micasa-data:/data --name micasa localhost/micasaweb``` 
3. Contribute to the project to make it better
