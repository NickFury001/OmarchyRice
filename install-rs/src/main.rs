use std::fs;
use std::env;

fn main() {
    let mut args: Vec<String> = env::args().collect();
    args.remove(0);
    if args.is_empty() {
        panic!("Error: Expected arg0 to contain new username, found null.");
    }

    let file_name = "./flake.nix";
    let mut file_contents: String = match fs::read_to_string(file_name) {
        Ok(file) => file,
        Err(error) => panic!("Error opening {}:, {}", file_name, error)
    };
    file_contents = file_contents.replace("yourusername", &args[0]);
    match fs::write(file_name, file_contents) {
        Err(error) => panic!("Error saving {}:, {}", file_name, error),
        Ok(_) => std::println!("{} updated with username {}", file_name, args[0])
    };
}
