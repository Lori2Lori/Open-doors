## An interface which allows users to open doors and see historical events

## Description


The application allows users to log into personal account, create, delete and open doors. There is also the history of opened doors, with exact date and door description.

Application is build with [React.js](https://facebook.github.io/react/)  library and [Material-ui](http://www.material-ui.com/#/) as a front-end framework. [Firebase](https://www.firebase.com/) is used for back-end, the app may be connected with other databases as well.


## Installation

Install by cloning git repository:

```bash
git clone ...
```

Inside repository directory install all dependencies listed in package.json using:

```bash
npm install
```

## Usage

To build and test the application locally, execute:

```bash
npm run develop
```

This command will build the application and run local web server and open a browser.

To deploy this app on your server just build it:

```bash
npm run prepublish
```

and copy files from `build` directory to the server.
