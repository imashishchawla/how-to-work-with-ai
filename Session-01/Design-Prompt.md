Design a small Docker Compose demo with 4 containers named dock1, dock2, dock3, and dock4 on the same custom Docker network.

Requirements:
- Create a `docker-compose.yml`.
- Use a lightweight Linux image such as Alpine or Ubuntu.
- Each container should stay running.
- Each container should be able to resolve and talk to the others by hostname: dock1, dock2, dock3, dock4.
- Install and run SSH server inside each container.
- Add my SSH public key into each container’s `authorized_keys`.
- Let me connect to each container using SSH with my private key.
- Expose each container’s SSH port on a different localhost port:
  - dock1: localhost:2221
  - dock2: localhost:2222
  - dock3: localhost:2223
  - dock4: localhost:2224
- Add a simple demo command or script so I can prove connectivity between containers, for example ping or ssh from dock1 to dock2/dock3/dock4.
- Share a clear list of all servers and SSH commands to connect to them.
- Add clear commands to:
  - start the demo
  - test connectivity
  - view running containers
  - delete/clean up everything after the demo
- Keep it simple and safe so it can be created and removed quickly.
- Explain each section briefly.

Use this SSH public key:
PASTE_MY_PUBLIC_KEY_HERE