-- Convert Y and N to true and false, respectively.  Handle " " as NULL. Handle NULL as NULL. Leave other values as is. More complete case coverage in this than previous version with code improvements from Pete Fein.

{% macro boolean_macro(column_name, true_value="Y", false_value="N", null_value=" ") -%}

    (CASE 
        WHEN TRIM(UPPER({{ column_name }})) = '{{true_value}}' THEN TRUE
        WHEN TRIM(UPPER({{ column_name }})) = '{{false_value}}' THEN FALSE
        WHEN TRIM(UPPER({{ column_name }})) = '{{null_value}}' THEN NULL
        WHEN TRIM(UPPER({{ column_name }})) IS NULL THEN NULL
        ELSE {{ column_name }}
    END)::bool

{%- endmacro %}