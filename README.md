# Tacata #

Download localization data from Google Spreadsheets and output it in easily manipulatable json files.

## Setup ##

* Add your google login data and desired output directory to ./config/config.pl:

```perl
+{
    output_dir => 'dev/tacata',  #relative to your home directory

    google_username => 'you@google.com',
    google_password => 'password',
    spreadsheet_key => '0AgLBBnhg8gXSeE03WTRBMEdJeFTpRlFUQjRFFUo4OBc', 
}
```

* Your spreadsheet key is the "key" parameter found in the url of your spreadsheet

* Optionally configure for multiple users by making ./config/config_[[yourusername]].pl 

## Usage ##

* To download your worksheets into json files (one file per worksheet): 

```bash
./script/tacata.pl import_strings 
```

* To display the help message:

```bash
./script/tacata.pl --help 
```
