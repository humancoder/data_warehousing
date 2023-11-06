-- this macro converts negative values to NULL

{% macro positive_macro(column_name) -%}

    CASE WHEN {{ column_name }} >= 0 THEN {{ column_name }}
         ELSE NULL
    END

{%- endmacro %}