import { defineConfig } from "eslint/config";
import jsoncParser from "jsonc-eslint-parser";
import { FlatCompat } from "@eslint/eslintrc";
import js from "@eslint/js";

const compat = new FlatCompat({
  recommendedConfig: js.configs.recommended,
});

export default defineConfig([
  compat.extends("eslint:recommended"),
  {
    files: ["**/*.json"],
    extends: compat.extends("plugin:jsonc/recommended-with-jsonc"),
    languageOptions: {
      parser: jsoncParser,
      parserOptions: { jsonSyntax: "JSONC" },
    },
  },
]);
