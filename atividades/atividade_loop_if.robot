***Test Cases***
iterate list
    Set Test Variable  @{numbers}  1  2  3  4  5  6  7  8  9  10
    Log To Console  ${\n}
    FOR  ${value}  IN  @{numbers}
        IF  ${value} in (5, 10)
            Log To Console  Eu sou o número ${value}
        ELSE
            Log To Console  Eu não sou o número 5 e nem o 10!
        END
    END
