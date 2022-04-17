%Absinthe.Blueprint{
  adapter: nil,
  directives: [],
  errors: [],
  execution: %Absinthe.Blueprint.Execution{
    acc: %{},
    adapter: nil,
    context: %{},
    fields_cache: %{},
    fragments: %{},
    result: nil,
    root_value: %{},
    schema: nil,
    validation_errors: []
  },
  flags: %{},
  fragments: [],
  initial_phases: [],
  input: nil,
  name: nil,
  operations: [],
  prototype_schema: nil,
  result: %{},
  schema: SeedsQueryWeb.Schema,
  schema_definitions: [
    %Absinthe.Blueprint.Schema.SchemaDefinition{
      __private__: [],
      __reference__: %{
        location: %{
          file: "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
          line: 0
        }
      },
      description: nil,
      directive_artifacts: [],
      directive_definitions: [],
      directives: [],
      errors: [],
      flags: %{},
      imports: [{SeedsQueryWeb.Schema.CommonTypes, []}],
      module: SeedsQueryWeb.Schema,
      schema_declaration: nil,
      source_location: nil,
      type_artifacts: [],
      type_definitions: [
        %Absinthe.Blueprint.Schema.ObjectTypeDefinition{
          __private__: [],
          __reference__: %{
            location: %{
              file:
                "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
              line: 124
            },
            module: SeedsQueryWeb.Schema
          },
          description: nil,
          directives: [],
          errors: [],
          fields: [
            %Absinthe.Blueprint.Schema.FieldDefinition{
              __private__: [],
              __reference__: %{
                location: %{
                  file:
                    "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                  line: 125
                },
                module: SeedsQueryWeb.Schema
              },
              arguments: [
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 126
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :where,
                  module: SeedsQueryWeb.Schema,
                  name: "where",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :accts_seeds_users_bool_exp
                },
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 127
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :skip,
                  module: SeedsQueryWeb.Schema,
                  name: "skip",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :integer
                },
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 128
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :limit,
                  module: SeedsQueryWeb.Schema,
                  name: "limit",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :integer
                }
              ],
              complexity:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:query, :list_users}}},
              config:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:query, :list_users}}},
              default_value: nil,
              deprecation: nil,
              description: nil,
              directives: [],
              errors: [],
              flags: %{},
              function_ref: {:query, :list_users},
              identifier: :list_users,
              middleware: [
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:query, :list_users}}}
              ],
              module: SeedsQueryWeb.Schema,
              name: "list_users",
              source_location: nil,
              triggers:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:query, :list_users}}},
              type: %Absinthe.Blueprint.TypeReference.List{
                errors: [],
                of_type: :accts_seeds_users
              }
            }
          ],
          flags: %{},
          identifier: :query,
          imports: [],
          interface_blueprints: [],
          interfaces: [],
          is_type_of:
            {:ref, SeedsQueryWeb.Schema, {Absinthe.Blueprint.Schema.ObjectTypeDefinition, :query}},
          module: SeedsQueryWeb.Schema,
          name: "RootQueryType",
          source_location: nil
        },
        %Absinthe.Blueprint.Schema.ObjectTypeDefinition{
          __private__: [],
          __reference__: %{
            location: %{
              file:
                "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
              line: 84
            },
            module: SeedsQueryWeb.Schema
          },
          description: nil,
          directives: [],
          errors: [],
          fields: [
            %Absinthe.Blueprint.Schema.FieldDefinition{
              __private__: [],
              __reference__: %{
                location: %{
                  file:
                    "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                  line: 93
                },
                module: SeedsQueryWeb.Schema
              },
              arguments: [],
              complexity:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :account}}},
              config:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :account}}},
              default_value: nil,
              deprecation: nil,
              description: nil,
              directives: [],
              errors: [],
              flags: %{},
              function_ref: {:accts_seeds_users, :account},
              identifier: :account,
              middleware: [
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :account}}}
              ],
              module: SeedsQueryWeb.Schema,
              name: "account",
              source_location: nil,
              triggers:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :account}}},
              type: :string
            },
            %Absinthe.Blueprint.Schema.FieldDefinition{
              __private__: [],
              __reference__: %{
                location: %{
                  file:
                    "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                  line: 109
                },
                module: SeedsQueryWeb.Schema
              },
              arguments: [
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 110
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :where,
                  module: SeedsQueryWeb.Schema,
                  name: "where",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :accts_seeds_vouches_bool_exp
                },
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 111
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :skip,
                  module: SeedsQueryWeb.Schema,
                  name: "skip",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :integer
                },
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 112
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :limit,
                  module: SeedsQueryWeb.Schema,
                  name: "limit",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :integer
                }
              ],
              complexity:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :vouches_by}}},
              config:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :vouches_by}}},
              default_value: nil,
              deprecation: nil,
              description: nil,
              directives: [],
              errors: [],
              flags: %{},
              function_ref: {:accts_seeds_users, :vouches_by},
              identifier: :vouches_by,
              middleware: [
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :vouches_by}}}
              ],
              module: SeedsQueryWeb.Schema,
              name: "vouches_by",
              source_location: nil,
              triggers:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :vouches_by}}},
              type: %Absinthe.Blueprint.TypeReference.List{
                errors: [],
                of_type: :accts_seeds_vouches
              }
            },
            %Absinthe.Blueprint.Schema.FieldDefinition{
              __private__: [],
              __reference__: %{
                location: %{
                  file:
                    "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                  line: 116
                },
                module: SeedsQueryWeb.Schema
              },
              arguments: [
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 117
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :where,
                  module: SeedsQueryWeb.Schema,
                  name: "where",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :accts_seeds_vouches_bool_exp
                },
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 118
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :skip,
                  module: SeedsQueryWeb.Schema,
                  name: "skip",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :integer
                },
                %Absinthe.Blueprint.Schema.InputValueDefinition{
                  __private__: [],
                  __reference__: %{
                    location: %{
                      file:
                        "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                      line: 119
                    },
                    module: SeedsQueryWeb.Schema
                  },
                  default_value: nil,
                  default_value_blueprint: nil,
                  deprecation: nil,
                  description: nil,
                  directives: [],
                  errors: [],
                  flags: %{},
                  identifier: :limit,
                  module: SeedsQueryWeb.Schema,
                  name: "limit",
                  placement: :argument_definition,
                  source_location: nil,
                  type: :integer
                }
              ],
              complexity:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :vouches_for}}},
              config:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :vouches_for}}},
              default_value: nil,
              deprecation: nil,
              description: nil,
              directives: [],
              errors: [],
              flags: %{},
              function_ref: {:accts_seeds_users, :vouches_for},
              identifier: :vouches_for,
              middleware: [
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :vouches_for}}}
              ],
              module: SeedsQueryWeb.Schema,
              name: "vouches_for",
              source_location: nil,
              triggers:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_users, :vouches_for}}},
              type: %Absinthe.Blueprint.TypeReference.List{
                errors: [],
                of_type: :accts_seeds_vouches
              }
            }
          ],
          flags: %{},
          identifier: :accts_seeds_users,
          imports: [],
          interface_blueprints: [],
          interfaces: [],
          is_type_of:
            {:ref, SeedsQueryWeb.Schema,
             {Absinthe.Blueprint.Schema.ObjectTypeDefinition, :accts_seeds_users}},
          module: SeedsQueryWeb.Schema,
          name: "AcctsSeedsUsers",
          source_location: nil
        },
        %Absinthe.Blueprint.Schema.ObjectTypeDefinition{
          __private__: [],
          __reference__: %{
            location: %{
              file:
                "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
              line: 62
            },
            module: SeedsQueryWeb.Schema
          },
          description: nil,
          directives: [],
          errors: [],
          fields: [
            %Absinthe.Blueprint.Schema.FieldDefinition{
              __private__: [],
              __reference__: %{
                location: %{
                  file:
                    "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                  line: 71
                },
                module: SeedsQueryWeb.Schema
              },
              arguments: [],
              complexity:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_vouches, :account}}},
              config:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_vouches, :account}}},
              default_value: nil,
              deprecation: nil,
              description: nil,
              directives: [],
              errors: [],
              flags: %{},
              function_ref: {:accts_seeds_vouches, :account},
              identifier: :account,
              middleware: [
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_vouches, :account}}}
              ],
              module: SeedsQueryWeb.Schema,
              name: "account",
              source_location: nil,
              triggers:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition, {:accts_seeds_vouches, :account}}},
              type: :string
            }
          ],
          flags: %{},
          identifier: :accts_seeds_vouches,
          imports: [],
          interface_blueprints: [],
          interfaces: [],
          is_type_of:
            {:ref, SeedsQueryWeb.Schema,
             {Absinthe.Blueprint.Schema.ObjectTypeDefinition, :accts_seeds_vouches}},
          module: SeedsQueryWeb.Schema,
          name: "AcctsSeedsVouches",
          source_location: nil
        },
        %Absinthe.Blueprint.Schema.InputObjectTypeDefinition{
          __private__: [],
          __reference__: %{
            location: %{
              file:
                "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
              line: 53
            },
            module: SeedsQueryWeb.Schema
          },
          description: nil,
          directives: [],
          errors: [],
          fields: [
            %Absinthe.Blueprint.Schema.FieldDefinition{
              __private__: [],
              __reference__: %{
                location: %{
                  file:
                    "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                  line: 57
                },
                module: SeedsQueryWeb.Schema
              },
              arguments: [],
              complexity:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition,
                  {:accts_seeds_vouches_bool_exp, :account}}},
              config:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition,
                  {:accts_seeds_vouches_bool_exp, :account}}},
              default_value: nil,
              deprecation: nil,
              description: nil,
              directives: [],
              errors: [],
              flags: %{},
              function_ref: {:accts_seeds_vouches_bool_exp, :account},
              identifier: :account,
              middleware: [
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition,
                  {:accts_seeds_vouches_bool_exp, :account}}}
              ],
              module: SeedsQueryWeb.Schema,
              name: "account",
              source_location: nil,
              triggers:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition,
                  {:accts_seeds_vouches_bool_exp, :account}}},
              type: :text_comparison_exp
            }
          ],
          flags: %{},
          identifier: :accts_seeds_vouches_bool_exp,
          imports: [],
          module: SeedsQueryWeb.Schema,
          name: "AcctsSeedsVouchesBoolExp",
          source_location: nil
        },
        %Absinthe.Blueprint.Schema.InputObjectTypeDefinition{
          __private__: [],
          __reference__: %{
            location: %{
              file:
                "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
              line: 41
            },
            module: SeedsQueryWeb.Schema
          },
          description: nil,
          directives: [],
          errors: [],
          fields: [
            %Absinthe.Blueprint.Schema.FieldDefinition{
              __private__: [],
              __reference__: %{
                location: %{
                  file:
                    "/Users/khempoudel/projects/seeds-query/lib/seeds_query_web/graphql/schema.ex",
                  line: 45
                },
                module: SeedsQueryWeb.Schema
              },
              arguments: [],
              complexity:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition,
                  {:accts_seeds_users_bool_exp, :account}}},
              config:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition,
                  {:accts_seeds_users_bool_exp, :account}}},
              default_value: nil,
              deprecation: nil,
              description: nil,
              directives: [],
              errors: [],
              flags: %{},
              function_ref: {:accts_seeds_users_bool_exp, :account},
              identifier: :account,
              middleware: [
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition,
                  {:accts_seeds_users_bool_exp, :account}}}
              ],
              module: SeedsQueryWeb.Schema,
              name: "account",
              source_location: nil,
              triggers:
                {:ref, SeedsQueryWeb.Schema,
                 {Absinthe.Blueprint.Schema.FieldDefinition,
                  {:accts_seeds_users_bool_exp, :account}}},
              type: :text_comparison_exp
            }
          ],
          flags: %{},
          identifier: :accts_seeds_users_bool_exp,
          imports: [],
          module: SeedsQueryWeb.Schema,
          name: "AcctsSeedsUsersBoolExp",
          source_location: nil
        }
      ],
      type_extensions: []
    }
  ],
  source: nil,
  telemetry: %{}
}
