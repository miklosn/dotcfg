function pi --wraps pi --description "pi coding agent, following the active llm profile"
    # pi ignores PI_PROVIDER/PI_MODEL; translate them to flags unless given explicitly.
    if set -q PI_PROVIDER; and not contains -- --provider $argv; and not contains -- --model $argv
        command pi --provider $PI_PROVIDER --model $PI_MODEL $argv
    else
        command pi $argv
    end
end
