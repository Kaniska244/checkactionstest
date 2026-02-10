import { defineConfig } from "eslint/config";
import { FlatCompat } from "@eslint/eslintrc";
import js from "@eslint/js";
import globals from "globals";
import jsoncParser from "jsonc-eslint-parser";

const compat = new FlatCompat();

export default defineConfig([
  js.configs.recommended,

  {
    files: ["**/*.js", "**/*.cjs"],
    languageOptions: {
      ecmaVersion: 2021,
      sourceType: "script",
      globals: {
        ...globals.node,
      },
    },
    rules: {
      "no-undef": "error",
    },
  },

  ...compat.extends("plugin:jsonc/recommended-with-jsonc"),
  {
    files: ["**/*.json"],
    languageOptions: {
      parser: jsoncParser,
      parserOptions: { jsonSyntax: "JSONC" },
    },
  },
]);