defmodule CucumberMessages.Attachment.ContentEncoding do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :IDENTITY | :BASE64

  field :IDENTITY, 0
  field :BASE64, 1
end

defmodule CucumberMessages.TestStepFinished.TestStepResult.Status do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer | :UNKNOWN | :PASSED | :SKIPPED | :PENDING | :UNDEFINED | :AMBIGUOUS | :FAILED

  field :UNKNOWN, 0
  field :PASSED, 1
  field :SKIPPED, 2
  field :PENDING, 3
  field :UNDEFINED, 4
  field :AMBIGUOUS, 5
  field :FAILED, 6
end

defmodule CucumberMessages.StepDefinition.StepDefinitionPattern.StepDefinitionPatternType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :CUCUMBER_EXPRESSION | :REGULAR_EXPRESSION

  field :CUCUMBER_EXPRESSION, 0
  field :REGULAR_EXPRESSION, 1
end

defmodule CucumberMessages.Envelope do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: {atom, any}
        }
  defstruct [:message]

  oneof :message, 0
  field :source, 1, type: CucumberMessages.Source, oneof: 0
  field :gherkin_document, 2, type: CucumberMessages.GherkinDocument, oneof: 0
  field :pickle, 3, type: CucumberMessages.Pickle, oneof: 0
  field :step_definition, 4, type: CucumberMessages.StepDefinition, oneof: 0
  field :hook, 5, type: CucumberMessages.Hook, oneof: 0
  field :parameter_type, 6, type: CucumberMessages.ParameterType, oneof: 0
  field :test_case, 7, type: CucumberMessages.TestCase, oneof: 0
  field :undefined_parameter_type, 8, type: CucumberMessages.UndefinedParameterType, oneof: 0
  field :test_run_started, 9, type: CucumberMessages.TestRunStarted, oneof: 0
  field :test_case_started, 10, type: CucumberMessages.TestCaseStarted, oneof: 0
  field :test_step_started, 11, type: CucumberMessages.TestStepStarted, oneof: 0
  field :attachment, 12, type: CucumberMessages.Attachment, oneof: 0
  field :test_step_finished, 13, type: CucumberMessages.TestStepFinished, oneof: 0
  field :test_case_finished, 14, type: CucumberMessages.TestCaseFinished, oneof: 0
  field :test_run_finished, 15, type: CucumberMessages.TestRunFinished, oneof: 0
  field :parse_error, 16, type: CucumberMessages.ParseError, oneof: 0
  field :meta, 17, type: CucumberMessages.Meta, oneof: 0
end

defmodule CucumberMessages.Meta.Product do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          version: String.t()
        }
  defstruct [:name, :version]

  field :name, 1, type: :string
  field :version, 2, type: :string
end

defmodule CucumberMessages.Meta.CI.Git do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          remote: String.t(),
          revision: String.t(),
          branch: String.t(),
          tag: String.t()
        }
  defstruct [:remote, :revision, :branch, :tag]

  field :remote, 1, type: :string
  field :revision, 2, type: :string
  field :branch, 3, type: :string
  field :tag, 4, type: :string
end

defmodule CucumberMessages.Meta.CI do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          url: String.t(),
          git: CucumberMessages.Meta.CI.Git.t() | nil
        }
  defstruct [:name, :url, :git]

  field :name, 1, type: :string
  field :url, 2, type: :string
  field :git, 3, type: CucumberMessages.Meta.CI.Git
end

defmodule CucumberMessages.Meta do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          protocol_version: String.t(),
          implementation: CucumberMessages.Meta.Product.t() | nil,
          runtime: CucumberMessages.Meta.Product.t() | nil,
          os: CucumberMessages.Meta.Product.t() | nil,
          cpu: CucumberMessages.Meta.Product.t() | nil,
          ci: CucumberMessages.Meta.CI.t() | nil
        }
  defstruct [:protocol_version, :implementation, :runtime, :os, :cpu, :ci]

  field :protocol_version, 1, type: :string
  field :implementation, 2, type: CucumberMessages.Meta.Product
  field :runtime, 3, type: CucumberMessages.Meta.Product
  field :os, 4, type: CucumberMessages.Meta.Product
  field :cpu, 5, type: CucumberMessages.Meta.Product
  field :ci, 6, type: CucumberMessages.Meta.CI
end

defmodule CucumberMessages.Timestamp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          seconds: integer,
          nanos: integer
        }
  defstruct [:seconds, :nanos]

  field :seconds, 1, type: :int64
  field :nanos, 2, type: :int32
end

defmodule CucumberMessages.Duration do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          seconds: integer,
          nanos: integer
        }
  defstruct [:seconds, :nanos]

  field :seconds, 1, type: :int64
  field :nanos, 2, type: :int32
end

defmodule CucumberMessages.Location do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          line: non_neg_integer,
          column: non_neg_integer
        }
  defstruct [:line, :column]

  field :line, 1, type: :uint32
  field :column, 2, type: :uint32
end

defmodule CucumberMessages.SourceReference do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          uri: String.t(),
          location: CucumberMessages.Location.t() | nil
        }
  defstruct [:uri, :location]

  field :uri, 1, type: :string
  field :location, 2, type: CucumberMessages.Location
end

defmodule CucumberMessages.Source do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          uri: String.t(),
          data: String.t(),
          media_type: String.t()
        }
  defstruct [:uri, :data, :media_type]

  field :uri, 1, type: :string
  field :data, 2, type: :string
  field :media_type, 3, type: :string
end

defmodule CucumberMessages.GherkinDocument.Comment do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          text: String.t()
        }
  defstruct [:location, :text]

  field :location, 1, type: CucumberMessages.Location
  field :text, 2, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.Tag do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          name: String.t(),
          id: String.t()
        }
  defstruct [:location, :name, :id]

  field :location, 1, type: CucumberMessages.Location
  field :name, 2, type: :string
  field :id, 3, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.FeatureChild.Rule do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          keyword: String.t(),
          name: String.t(),
          description: String.t(),
          children: [CucumberMessages.GherkinDocument.Feature.FeatureChild.RuleChild.t()],
          id: String.t()
        }
  defstruct [:location, :keyword, :name, :description, :children, :id]

  field :location, 1, type: CucumberMessages.Location
  field :keyword, 2, type: :string
  field :name, 3, type: :string
  field :description, 4, type: :string

  field :children, 5,
    repeated: true,
    type: CucumberMessages.GherkinDocument.Feature.FeatureChild.RuleChild

  field :id, 6, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.FeatureChild.RuleChild do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :background, 1, type: CucumberMessages.GherkinDocument.Feature.Background, oneof: 0
  field :scenario, 2, type: CucumberMessages.GherkinDocument.Feature.Scenario, oneof: 0
end

defmodule CucumberMessages.GherkinDocument.Feature.FeatureChild do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :rule, 1, type: CucumberMessages.GherkinDocument.Feature.FeatureChild.Rule, oneof: 0
  field :background, 2, type: CucumberMessages.GherkinDocument.Feature.Background, oneof: 0
  field :scenario, 3, type: CucumberMessages.GherkinDocument.Feature.Scenario, oneof: 0
end

defmodule CucumberMessages.GherkinDocument.Feature.Background do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          keyword: String.t(),
          name: String.t(),
          description: String.t(),
          steps: [CucumberMessages.GherkinDocument.Feature.Step.t()],
          id: String.t()
        }
  defstruct [:location, :keyword, :name, :description, :steps, :id]

  field :location, 1, type: CucumberMessages.Location
  field :keyword, 2, type: :string
  field :name, 3, type: :string
  field :description, 4, type: :string
  field :steps, 5, repeated: true, type: CucumberMessages.GherkinDocument.Feature.Step
  field :id, 6, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.Scenario.Examples do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          tags: [CucumberMessages.GherkinDocument.Feature.Tag.t()],
          keyword: String.t(),
          name: String.t(),
          description: String.t(),
          table_header: CucumberMessages.GherkinDocument.Feature.TableRow.t() | nil,
          table_body: [CucumberMessages.GherkinDocument.Feature.TableRow.t()],
          id: String.t()
        }
  defstruct [:location, :tags, :keyword, :name, :description, :table_header, :table_body, :id]

  field :location, 1, type: CucumberMessages.Location
  field :tags, 2, repeated: true, type: CucumberMessages.GherkinDocument.Feature.Tag
  field :keyword, 3, type: :string
  field :name, 4, type: :string
  field :description, 5, type: :string
  field :table_header, 6, type: CucumberMessages.GherkinDocument.Feature.TableRow
  field :table_body, 7, repeated: true, type: CucumberMessages.GherkinDocument.Feature.TableRow
  field :id, 8, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.Scenario do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          tags: [CucumberMessages.GherkinDocument.Feature.Tag.t()],
          keyword: String.t(),
          name: String.t(),
          description: String.t(),
          steps: [CucumberMessages.GherkinDocument.Feature.Step.t()],
          examples: [CucumberMessages.GherkinDocument.Feature.Scenario.Examples.t()],
          id: String.t()
        }
  defstruct [:location, :tags, :keyword, :name, :description, :steps, :examples, :id]

  field :location, 1, type: CucumberMessages.Location
  field :tags, 2, repeated: true, type: CucumberMessages.GherkinDocument.Feature.Tag
  field :keyword, 3, type: :string
  field :name, 4, type: :string
  field :description, 5, type: :string
  field :steps, 6, repeated: true, type: CucumberMessages.GherkinDocument.Feature.Step

  field :examples, 7,
    repeated: true,
    type: CucumberMessages.GherkinDocument.Feature.Scenario.Examples

  field :id, 8, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.TableRow.TableCell do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          value: String.t()
        }
  defstruct [:location, :value]

  field :location, 1, type: CucumberMessages.Location
  field :value, 2, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.TableRow do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          cells: [CucumberMessages.GherkinDocument.Feature.TableRow.TableCell.t()],
          id: String.t()
        }
  defstruct [:location, :cells, :id]

  field :location, 1, type: CucumberMessages.Location

  field :cells, 2,
    repeated: true,
    type: CucumberMessages.GherkinDocument.Feature.TableRow.TableCell

  field :id, 3, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.Step.DataTable do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          rows: [CucumberMessages.GherkinDocument.Feature.TableRow.t()]
        }
  defstruct [:location, :rows]

  field :location, 1, type: CucumberMessages.Location
  field :rows, 2, repeated: true, type: CucumberMessages.GherkinDocument.Feature.TableRow
end

defmodule CucumberMessages.GherkinDocument.Feature.Step.DocString do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          media_type: String.t(),
          content: String.t(),
          delimiter: String.t()
        }
  defstruct [:location, :media_type, :content, :delimiter]

  field :location, 1, type: CucumberMessages.Location
  field :media_type, 2, type: :string
  field :content, 3, type: :string
  field :delimiter, 4, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature.Step do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          argument: {atom, any},
          location: CucumberMessages.Location.t() | nil,
          keyword: String.t(),
          text: String.t(),
          id: String.t()
        }
  defstruct [:argument, :location, :keyword, :text, :id]

  oneof :argument, 0
  field :location, 1, type: CucumberMessages.Location
  field :keyword, 2, type: :string
  field :text, 3, type: :string
  field :doc_string, 4, type: CucumberMessages.GherkinDocument.Feature.Step.DocString, oneof: 0
  field :data_table, 5, type: CucumberMessages.GherkinDocument.Feature.Step.DataTable, oneof: 0
  field :id, 6, type: :string
end

defmodule CucumberMessages.GherkinDocument.Feature do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          location: CucumberMessages.Location.t() | nil,
          tags: [CucumberMessages.GherkinDocument.Feature.Tag.t()],
          language: String.t(),
          keyword: String.t(),
          name: String.t(),
          description: String.t(),
          children: [CucumberMessages.GherkinDocument.Feature.FeatureChild.t()]
        }
  defstruct [:location, :tags, :language, :keyword, :name, :description, :children]

  field :location, 1, type: CucumberMessages.Location
  field :tags, 2, repeated: true, type: CucumberMessages.GherkinDocument.Feature.Tag
  field :language, 3, type: :string
  field :keyword, 4, type: :string
  field :name, 5, type: :string
  field :description, 6, type: :string
  field :children, 7, repeated: true, type: CucumberMessages.GherkinDocument.Feature.FeatureChild
end

defmodule CucumberMessages.GherkinDocument do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          uri: String.t(),
          feature: CucumberMessages.GherkinDocument.Feature.t() | nil,
          comments: [CucumberMessages.GherkinDocument.Comment.t()]
        }
  defstruct [:uri, :feature, :comments]

  field :uri, 1, type: :string
  field :feature, 2, type: CucumberMessages.GherkinDocument.Feature
  field :comments, 3, repeated: true, type: CucumberMessages.GherkinDocument.Comment
end

defmodule CucumberMessages.Attachment do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          source: CucumberMessages.SourceReference.t() | nil,
          test_step_id: String.t(),
          test_case_started_id: String.t(),
          body: String.t(),
          media_type: String.t(),
          content_encoding: CucumberMessages.Attachment.ContentEncoding.t()
        }
  defstruct [:source, :test_step_id, :test_case_started_id, :body, :media_type, :content_encoding]

  field :source, 1, type: CucumberMessages.SourceReference
  field :test_step_id, 2, type: :string
  field :test_case_started_id, 3, type: :string
  field :body, 4, type: :string
  field :media_type, 5, type: :string
  field :content_encoding, 6, type: CucumberMessages.Attachment.ContentEncoding, enum: true
end

defmodule CucumberMessages.Pickle.PickleTag do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          ast_node_id: String.t()
        }
  defstruct [:name, :ast_node_id]

  field :name, 1, type: :string
  field :ast_node_id, 2, type: :string
end

defmodule CucumberMessages.Pickle.PickleStep do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          text: String.t(),
          argument: CucumberMessages.PickleStepArgument.t() | nil,
          id: String.t(),
          ast_node_ids: [String.t()]
        }
  defstruct [:text, :argument, :id, :ast_node_ids]

  field :text, 1, type: :string
  field :argument, 2, type: CucumberMessages.PickleStepArgument
  field :id, 3, type: :string
  field :ast_node_ids, 4, repeated: true, type: :string
end

defmodule CucumberMessages.Pickle do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          uri: String.t(),
          name: String.t(),
          language: String.t(),
          steps: [CucumberMessages.Pickle.PickleStep.t()],
          tags: [CucumberMessages.Pickle.PickleTag.t()],
          ast_node_ids: [String.t()]
        }
  defstruct [:id, :uri, :name, :language, :steps, :tags, :ast_node_ids]

  field :id, 1, type: :string
  field :uri, 2, type: :string
  field :name, 3, type: :string
  field :language, 4, type: :string
  field :steps, 5, repeated: true, type: CucumberMessages.Pickle.PickleStep
  field :tags, 6, repeated: true, type: CucumberMessages.Pickle.PickleTag
  field :ast_node_ids, 7, repeated: true, type: :string
end

defmodule CucumberMessages.PickleStepArgument.PickleDocString do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          media_type: String.t(),
          content: String.t()
        }
  defstruct [:media_type, :content]

  field :media_type, 1, type: :string
  field :content, 2, type: :string
end

defmodule CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow.PickleTableCell do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: String.t()
        }
  defstruct [:value]

  field :value, 1, type: :string
end

defmodule CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          cells: [
            CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow.PickleTableCell.t()
          ]
        }
  defstruct [:cells]

  field :cells, 1,
    repeated: true,
    type: CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow.PickleTableCell
end

defmodule CucumberMessages.PickleStepArgument.PickleTable do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          rows: [CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow.t()]
        }
  defstruct [:rows]

  field :rows, 1,
    repeated: true,
    type: CucumberMessages.PickleStepArgument.PickleTable.PickleTableRow
end

defmodule CucumberMessages.PickleStepArgument do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: {atom, any}
        }
  defstruct [:message]

  oneof :message, 0
  field :doc_string, 1, type: CucumberMessages.PickleStepArgument.PickleDocString, oneof: 0
  field :data_table, 2, type: CucumberMessages.PickleStepArgument.PickleTable, oneof: 0
end

defmodule CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.StepMatchArgument.Group do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          start: non_neg_integer,
          value: String.t(),
          children: [
            CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.StepMatchArgument.Group.t()
          ]
        }
  defstruct [:start, :value, :children]

  field :start, 1, type: :uint32
  field :value, 2, type: :string

  field :children, 3,
    repeated: true,
    type: CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.StepMatchArgument.Group
end

defmodule CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.StepMatchArgument do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          parameter_type_name: String.t(),
          group:
            CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.StepMatchArgument.Group.t()
            | nil
        }
  defstruct [:parameter_type_name, :group]

  field :parameter_type_name, 1, type: :string

  field :group, 2,
    type: CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.StepMatchArgument.Group
end

defmodule CucumberMessages.TestCase.TestStep.StepMatchArgumentsList do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          step_match_arguments: [
            CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.StepMatchArgument.t()
          ]
        }
  defstruct [:step_match_arguments]

  field :step_match_arguments, 1,
    repeated: true,
    type: CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.StepMatchArgument
end

defmodule CucumberMessages.TestCase.TestStep do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          pickle_step_id: String.t(),
          step_definition_ids: [String.t()],
          step_match_arguments_lists: [
            CucumberMessages.TestCase.TestStep.StepMatchArgumentsList.t()
          ],
          hook_id: String.t()
        }
  defstruct [:id, :pickle_step_id, :step_definition_ids, :step_match_arguments_lists, :hook_id]

  field :id, 1, type: :string
  field :pickle_step_id, 2, type: :string
  field :step_definition_ids, 3, repeated: true, type: :string

  field :step_match_arguments_lists, 4,
    repeated: true,
    type: CucumberMessages.TestCase.TestStep.StepMatchArgumentsList

  field :hook_id, 5, type: :string
end

defmodule CucumberMessages.TestCase do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          pickle_id: String.t(),
          test_steps: [CucumberMessages.TestCase.TestStep.t()]
        }
  defstruct [:id, :pickle_id, :test_steps]

  field :id, 1, type: :string
  field :pickle_id, 2, type: :string
  field :test_steps, 3, repeated: true, type: CucumberMessages.TestCase.TestStep
end

defmodule CucumberMessages.TestRunStarted do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          timestamp: CucumberMessages.Timestamp.t() | nil
        }
  defstruct [:timestamp]

  field :timestamp, 1, type: CucumberMessages.Timestamp
end

defmodule CucumberMessages.TestCaseStarted do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          timestamp: CucumberMessages.Timestamp.t() | nil,
          attempt: non_neg_integer,
          test_case_id: String.t(),
          id: String.t()
        }
  defstruct [:timestamp, :attempt, :test_case_id, :id]

  field :timestamp, 1, type: CucumberMessages.Timestamp
  field :attempt, 3, type: :uint32
  field :test_case_id, 4, type: :string
  field :id, 5, type: :string
end

defmodule CucumberMessages.TestCaseFinished do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          timestamp: CucumberMessages.Timestamp.t() | nil,
          test_case_started_id: String.t()
        }
  defstruct [:timestamp, :test_case_started_id]

  field :timestamp, 1, type: CucumberMessages.Timestamp
  field :test_case_started_id, 3, type: :string
end

defmodule CucumberMessages.TestStepStarted do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          timestamp: CucumberMessages.Timestamp.t() | nil,
          test_step_id: String.t(),
          test_case_started_id: String.t()
        }
  defstruct [:timestamp, :test_step_id, :test_case_started_id]

  field :timestamp, 1, type: CucumberMessages.Timestamp
  field :test_step_id, 2, type: :string
  field :test_case_started_id, 3, type: :string
end

defmodule CucumberMessages.TestStepFinished.TestStepResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status: CucumberMessages.TestStepFinished.TestStepResult.Status.t(),
          message: String.t(),
          duration: CucumberMessages.Duration.t() | nil,
          will_be_retried: boolean
        }
  defstruct [:status, :message, :duration, :will_be_retried]

  field :status, 1, type: CucumberMessages.TestStepFinished.TestStepResult.Status, enum: true
  field :message, 2, type: :string
  field :duration, 3, type: CucumberMessages.Duration
  field :will_be_retried, 4, type: :bool
end

defmodule CucumberMessages.TestStepFinished do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          test_step_result: CucumberMessages.TestStepFinished.TestStepResult.t() | nil,
          timestamp: CucumberMessages.Timestamp.t() | nil,
          test_step_id: String.t(),
          test_case_started_id: String.t()
        }
  defstruct [:test_step_result, :timestamp, :test_step_id, :test_case_started_id]

  field :test_step_result, 1, type: CucumberMessages.TestStepFinished.TestStepResult
  field :timestamp, 2, type: CucumberMessages.Timestamp
  field :test_step_id, 3, type: :string
  field :test_case_started_id, 4, type: :string
end

defmodule CucumberMessages.TestRunFinished do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          success: boolean,
          timestamp: CucumberMessages.Timestamp.t() | nil,
          message: String.t()
        }
  defstruct [:success, :timestamp, :message]

  field :success, 1, type: :bool
  field :timestamp, 2, type: CucumberMessages.Timestamp
  field :message, 3, type: :string
end

defmodule CucumberMessages.Hook do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          tag_expression: String.t(),
          source_reference: CucumberMessages.SourceReference.t() | nil
        }
  defstruct [:id, :tag_expression, :source_reference]

  field :id, 1, type: :string
  field :tag_expression, 2, type: :string
  field :source_reference, 3, type: CucumberMessages.SourceReference
end

defmodule CucumberMessages.StepDefinition.StepDefinitionPattern do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          source: String.t(),
          type:
            CucumberMessages.StepDefinition.StepDefinitionPattern.StepDefinitionPatternType.t()
        }
  defstruct [:source, :type]

  field :source, 1, type: :string

  field :type, 2,
    type: CucumberMessages.StepDefinition.StepDefinitionPattern.StepDefinitionPatternType,
    enum: true
end

defmodule CucumberMessages.StepDefinition do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          pattern: CucumberMessages.StepDefinition.StepDefinitionPattern.t() | nil,
          source_reference: CucumberMessages.SourceReference.t() | nil
        }
  defstruct [:id, :pattern, :source_reference]

  field :id, 1, type: :string
  field :pattern, 2, type: CucumberMessages.StepDefinition.StepDefinitionPattern
  field :source_reference, 3, type: CucumberMessages.SourceReference
end

defmodule CucumberMessages.ParameterType do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          regular_expressions: [String.t()],
          prefer_for_regular_expression_match: boolean,
          use_for_snippets: boolean,
          id: String.t()
        }
  defstruct [
    :name,
    :regular_expressions,
    :prefer_for_regular_expression_match,
    :use_for_snippets,
    :id
  ]

  field :name, 1, type: :string
  field :regular_expressions, 2, repeated: true, type: :string
  field :prefer_for_regular_expression_match, 3, type: :bool
  field :use_for_snippets, 4, type: :bool
  field :id, 5, type: :string
end

defmodule CucumberMessages.UndefinedParameterType do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          expression: String.t()
        }
  defstruct [:name, :expression]

  field :name, 1, type: :string
  field :expression, 2, type: :string
end

defmodule CucumberMessages.ParseError do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          source: CucumberMessages.SourceReference.t() | nil,
          message: String.t()
        }
  defstruct [:source, :message]

  field :source, 1, type: CucumberMessages.SourceReference
  field :message, 2, type: :string
end
