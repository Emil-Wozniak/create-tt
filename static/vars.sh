#!/usr/bin/env bash
#Author emil.wozniak.591986@gmail.com

package_react_start='s/    "start": "react-scripts start",/    \"start\"\: \"npm run tailwind\:css \&\& react\-scripts start\", \"tailwind\:css\"\:\"tailwind build src\/tailwind.css -c tailwind.config.js \-o src\/index.css\",/g'
package_react_build='s/    "build": "react-scripts build",/    \"build\"\: \"npm run tailwind\:css \&\& react\-scripts build\",/g'


postcss="const tailwindcss = require('tailwindcss');
module.exports = {
  plugins: [
         tailwindcss('./tailwind.js'),
         require('autoprefixer'),
     ],
 };"

tailwind_config="module.exports = {
  theme: {
    minHeight: {
      '0': '0',
      '1/4': '25%',
      '1/2': '50%',
      '3/4': '75%',
      'full': '100%',
    },
    extend: {}
  },
  variants: {},
  plugins: [
  ]
}"

tailwind='@tailwind base; @tailwind components; @tailwind utilities;'

app_tsx='import React from "react";
import "./App.css";
import Header from "./components/shared/layout/header/header";
import Footer from "./components/shared/layout/footer/footer";
import {
    APP_CONTAINER,
    BODY_CONTENT, FORM_LOGIN,
    SIGN_IN_INPUT,
    SIGN_IN_LABEL,
    PASS_INPUT, SIGN_IN_BTN
} from "./components/shared/layout/styles/style-constants";

const App: React.FC = () => {
    return (
        <div className={APP_CONTAINER}>
            <Header title="header title"/>
            <div className={APP_CONTAINER}>
                <div className={BODY_CONTENT}>
                    <form action="" className={FORM_LOGIN}>
                        <div className="px-4 pb-4">
                            <label htmlFor="email" className={SIGN_IN_LABEL}>EMAIL ADDRESS</label>
                            <input
                                type="email"
                                name="email"
                                id=""
                                className={SIGN_IN_INPUT}
                                placeholder="example@example.com"/>
                        </div>
                        <div className="px-4 pb-4">
                            <label htmlFor="password" className={SIGN_IN_LABEL}>PASSWORD</label>
                            <input
                                type="password"
                                name="email"
                                id=""
                                className={PASS_INPUT}
                                placeholder="Enter your password"/>
                        </div>
                        <div>
                            <button
                                className={SIGN_IN_BTN}
                                type="button">Sign In
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <Footer title={"Here you can put your footer info"}/>
        </div>)
};

export default App;'

style_constant='/* LAYOUT */
export const APP_CONTAINER = "m-auto antialiased font-sans font-serif font-mono text-center";
export const HEADER_CONTAINER = "bg-blue-500 w-full flex flex-col sticky top-0 pt-12";
export const HEADER_TEXT="text-center text-orange-500 font-bold";

/* INPUT */
export const BODY_CONTENT ="bg-orange-500 min-h-screen flex flex-col items-center justify-center text-white p-4";
export const SEARCH_INPUT = "text-gray-500 rounded m-4 py-4 px-6 hover:shadow hover:bg-blue-600";

export const FORM_LOGIN = "bg-white shadow-md rounded px-8 py-8 pt-8";
export const SIGN_IN_LABEL = "text-sm block font-bold pb-2";
export const SIGN_IN_INPUT = "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline border-blue-300";
export const PASS_INPUT = "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline border-blue-300";
export const SIGN_IN_BTN = "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline";

/* CARD LAYOUT */
export const CARD = "max-w-sm rounded overflow-hidden shadow-lg bg-white hover:opacity-50";
export const CELL = "w-1/5 py-1 m-2";
export const CARD_BODY = "px-6 py-4";

/* LIST ELEMENT */
export const ORANGE_LIST = "hover:text-orange-500 text-gray-500";
export const BLUE_LIST = "hover:text-blue-500 text-gray-500";
export const DARK_GREEN_LIST = "hover:text-green-900 text-gray-500";
export const LIGHT_GREEN_LIST = "hover:text-green-300 text-gray-500";'

header='import React from "react";
import {HEADER_CONTAINER, HEADER_TEXT} from "../styles/style-constants";

interface IHeader {
    title: string;
}
const Header = (props: IHeader) =>
            <header className={HEADER_CONTAINER}>
                <h1 className={HEADER_TEXT}>
                    {props.title}
                </h1>
            </header>;


export default Header;
'

grid='import React from "react";

interface IColumnSection {
    children: any;
    name: string;
    nameClass: string;
}

export const ColumnSection = (props: IColumnSection) =>
    <div className="w-1/4 h-auto">
        <div className={props.nameClass}>
            {props.name}
        </div>
        <ul className="list-reset leading-normal">
            {props.children}
        </ul>
    </div>;

interface IColumnElement {
    children: any;
    listClass: string;
}

export const ColumnElement = (props: IColumnElement) =>
    <li className={props.listClass}>
        {props.children}
    </li>;
'

footer='import React from "react";
import {ColumnElement, ColumnSection} from "../grid/grid.components";
import {BLUE_LIST, DARK_GREEN_LIST, ORANGE_LIST} from "../styles/style-constants";

interface IFooter {
    title: string;
}

const Footer = (props: IFooter) =>
    <footer>
        <div className="container p-4">
            <div className="flex mb-4">
                <ColumnSection
                    name={"Orange"}
                    nameClass={"text-orange mb-2"}>
                    <ColumnElement
                        listClass={ORANGE_LIST}>
                        One
                    </ColumnElement>
                </ColumnSection>
                <ColumnSection
                    name={"Blue"}
                    nameClass={"text-blue mb-2"}>
                    <ColumnElement listClass={BLUE_LIST}>
                        One
                    </ColumnElement>
                    <ColumnElement listClass={BLUE_LIST}>
                        Two
                    </ColumnElement>
                    <ColumnElement listClass={BLUE_LIST}>
                        Three
                    </ColumnElement>
                </ColumnSection>
                <ColumnSection
                    name="Green-dark"
                    nameClass={"text-green-dark mb-2"}>
                    <ColumnElement listClass={DARK_GREEN_LIST}>
                        One
                    </ColumnElement>
                    <ColumnElement listClass={DARK_GREEN_LIST}>
                        Two
                    </ColumnElement>
                    <ColumnElement listClass={DARK_GREEN_LIST}>
                        Three
                    </ColumnElement>
                </ColumnSection>
                <ColumnSection
                    name={"Newsletter"}
                    nameClass={"text-yellow-700 mb-2"}>
                    <p className="text-gray-500 leading-normal">
                        Lorem ipsum dolor sit amet, consectetur adipisicing
                        elit.
                        Commodi, consectetur.
                    </p>
                </ColumnSection>
            </div>
            {props.title}
        </div>
    </footer>;


export default Footer;'

export DATA
