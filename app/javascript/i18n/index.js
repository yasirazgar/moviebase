import en from "./en.json";

const languages = {
  en
};

export default (language = "en") => {
  return languages[language];
};