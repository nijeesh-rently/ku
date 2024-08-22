# Kubectl Helper

## Description

**Kubectl Helper** is a command-line utility designed to simplify common tasks when working with Kubernetes clusters. It provides a set of commands for managing secrets, contexts, databases, logs, and more, all from a single, easy-to-use interface.

## Installation

To install Kubectl Helper, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/nijeesh-rently/ku
   cd ku
   ```

2. Run the `install` script to set up the environment:

   ```bash
   bin/install
   ```

   This script will:
   - Check if Ruby is installed.
   - Check if Bundler is installed, and install it if necessary.
   - Install the required gems using Bundler.
   - Create a symlink to `/usr/local/bin/ku` for easy access.

## Usage

Once installed, you can use the `ku` command to interact with your Kubernetes cluster. Here are some examples:

- **List all contexts:**

  ```bash
  ku context
  ```

- **Connect to a PostgreSQL database inside a pod:**

  ```bash
  ku database NAME
  ```

- **Execute a command inside a pod:**

  ```bash
  ku exec NAME [COMMAND]
  ```

- **Get logs from a pod:**

  ```bash
  ku logs NAME [FILTER]
  ```

- **Manage secrets:**

  ```bash
  ku secret [ARGUMENT] [SUBCOMMAND]
  ```

  - `ku secret get`: Retrieve environment variables from a pod.
  - `ku secret set`: Set environment variables in a pod.

- **Switch between namespaces:**

  ```bash
  ku switch NAMESPACE
  ```

For more information on available commands, use the `--help` option:

```bash
ku --help
```

## Commands

Here’s a summary of the available commands:

- **context**: List all contexts.
- **database**: Connect to a PostgreSQL database.
- **exec**: Run a command inside a pod.
- **logs**: Retrieve logs from a pod.
- **secret**: Manage secrets (get/set environment variables).
- **switch**: Switch between namespaces.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or feature requests.

---

You can customize the sections based on your specific project needs. Let me know if you'd like to add or modify anything in this template!
