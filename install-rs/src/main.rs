use std::fs;
use std::env;

fn main() {
    let mut args: Vec<String> = env::args().collect();
    args.remove(0);
    if args.len() != 2 {
        panic!("Error: Expected two arguments.");
    }

    let file_name = &args[1];
    let mut file_contents: String = match fs::read_to_string(file_name) {
        Ok(file) => file,
        Err(error) => panic!("Error opening {}:, {}", file_name, error)
    };

    file_contents = file_contents.replace("your_username_here", &args[0]);
    match fs::write(file_name, file_contents) {
        Err(error) => panic!("Error saving {}:, {}", file_name, error),
        Ok(_) => std::println!("{} updated with username {}", file_name, args[0])
    };
}
