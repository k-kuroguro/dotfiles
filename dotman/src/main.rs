use clap::{Parser, Subcommand};

#[derive(Debug, Parser)]
#[command(
   name = env!("CARGO_PKG_NAME"),
   version = env!("CARGO_PKG_VERSION"),
   about = env!("CARGO_PKG_DESCRIPTION"),
   arg_required_else_help = true
)]
struct Cli {
   #[command(subcommand)]
   command: Commands,
}

#[derive(Debug, Subcommand)]
enum Commands {
   #[command(about = "Install dotfiles")]
   Install,
   #[command(about = "Uninstall dotfiles")]
   Uninstall,
   #[command(about = "Backup existing dotfiles")]
   Backup,
}

fn main() {
   let args = Cli::parse();

   match args.command {
      Commands::Install {} => {
         println!("Installing dotfiles...");
      }
      Commands::Uninstall {} => {
         println!("Uninstalling dotfiles...");
      }
      Commands::Backup {} => {
         println!("Backing up existing dotfiles...");
      }
   }
}
