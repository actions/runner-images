############################
### Abstract base nodes ####
############################

# Abstract base class for all nodes
class BaseNode {
    [Boolean] ShouldBeIncludedToDiff() {
        return $false
    }

    [String] ToMarkdown() {
        return $this.ToMarkdown(1)
    }

    [String] ToMarkdown([Int32] $Level) {
        throw "Abtract method 'ToMarkdown(level)' is not implemented for '$($this.GetType().Name)'"
    }

    [Boolean] IsSimilarTo([BaseNode] $OtherNode) {
        throw "Abtract method 'IsSimilarTo' is not implemented for '$($this.GetType().Name)'"
    }

    [Boolean] IsIdenticalTo([BaseNode] $OtherNode) {
        throw "Abtract method 'IsIdenticalTo' is not implemented for '$($this.GetType().Name)'"
    }
}

# Abstract base class for all nodes that describe a tool and should be rendered inside diff table
class BaseToolNode: BaseNode {
    [ValidateNotNullOrEmpty()]
    [String] $ToolName

    BaseToolNode([String] $ToolName) {
        $this.ToolName = $ToolName
    }

    [Boolean] ShouldBeIncludedToDiff() {
        return $true
    }

    [String] GetValue() {
        throw "Abtract method 'GetValue' is not implemented for '$($this.GetType().Name)'"
    }

    [Boolean] IsSimilarTo([BaseNode] $OtherNode) {
        if ($this.GetType() -ne $OtherNode.GetType()) {
            return $false
        }

        return $this.ToolName -eq $OtherNode.ToolName
    }

    [Boolean] IsIdenticalTo([BaseNode] $OtherNode) {
        return $this.IsSimilarTo($OtherNode) -and ($this.GetValue() -eq $OtherNode.GetValue())
    }
}