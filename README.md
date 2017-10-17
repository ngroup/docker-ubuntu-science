# docker-ubuntu-science
Basic Python environment for scientific usage in Ubuntu with the SSH ability.


## Usage

Note: In the following commands, the brackets (`{}`) indicate a changeable variable.

For example, `{username}` can be replaced by  `someusernameyoudliketouse`

### Build Image
```bash
$ docker build --build-arg user={username} --build-arg pwd={userpassword} -t science/ubuntu https://github.com/ngroup/docker-ubuntu-science.git
```

### Run a Ubuntu Container
```bash
$ docker run --privileged -d -p 2222:22 -v {path_to_host_directory}:/home/{username} --name {container_name} science/ubuntu
```

### SSH to the Container
```bash
$ ssh -p 2222 {username}@{host_ip}
```

## Author
**Chun Nien** {contact@chunnien.com}
