-- macro to convert Y or N to boolean, Y to true, N to false

{% macro boolean_macro(column_name) -%}

    CASE WHEN {{ column_name }} = 'Y' THEN TRUE
         WHEN {{ column_name }} = 'N' THEN FALSE
         ELSE NULL
    END

{%- endmacro %}