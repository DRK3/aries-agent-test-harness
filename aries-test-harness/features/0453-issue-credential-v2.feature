@RFC0453 @AIP20
Feature: RFC 0453 Aries Agent Issue Credential v2

  # is this background needed with v2 AIP20?
  Background: create a schema and credential definition in order to issue a credential
    Given "Acme" has a public did
    And "Acme" is ready to issue a credential

  @T001-RFC0453 @critical @AcceptanceTest @DIDExchangeConnection @Schema_DriversLicense
  Scenario Outline: Issue a credential with the Holder beginning with a proposal
    Given "2" agents
      | name | role   |
      | Acme | issuer |
      | Bob  | holder |
    And "Acme" and "Bob" have an existing connection
    When "Bob" proposes a credential to "Acme" with <credential_data>
    And "Acme" offers a credential
    And "Bob" requests the credential
    And "Acme" issues the credential
    And "Bob" acknowledges the credential issue
    Then "Bob" has the credential issued

    Examples:
      | credential_data   | request_for_proof            | presentation                |
      | Data_DL_MaxValues | proof_request_DL_address     | presentation_DL_address     |


  @T001.1-RFC0036 @critical @wip @AcceptanceTest @DIDExchangeConnection
  Scenario: Issue a credential with the Holder beginning with a proposal with DID Exchange Connection
    Given "2" agents
      | name | role   |
      | Acme | issuer |
      | Bob  | holder |
    And "Acme" and "Bob" have an existing connection
    When "Bob" proposes a credential to "Acme"
    And "Acme" offers a credential
    And "Bob" requests the credential
    And "Acme" issues the credential
    And "Bob" acknowledges the credential issue
    Then "Bob" has the credential issued

  @T002-RFC0036 @normal @wip @AcceptanceTest
  Scenario: Issue a credential with the Holder beginning with a proposal with negotiation
    Given "2" agents
      | name | role   |
      | Acme | issuer |
      | Bob  | holder |
    And "Acme" and "Bob" have an existing connection
    And "Bob" proposes a credential to "Acme"
    And "Acme" offers a credential
    When "Bob" negotiates the offer with another proposal of the credential to "Acme"
    And "Acme" Offers the credential
    And "Bob" requests the credential
    And "Acme" issues the credential
    And "Bob" acknowledges the credential issue
    Then "Bob" has the credential issued

  @T003-RFC0036 @critical @wip @AcceptanceTest
  Scenario: Issue a credential with the Issuer beginning with an offer
    Given "2" agents
      | name | role   |
      | Acme | issuer |
      | Bob  | holder |
    And "Acme" and "Bob" have an existing connection
    When "Acme" offers a credential
    And "Bob" requests the credential
    And "Acme" issues the credential
    And "Bob" acknowledges the credential issue
    Then "Bob" has the credential issued

  @T004-RFC0036 @normal @wip @AcceptanceTest
  Scenario: Issue a credential with the Issuer beginning with an offer with negotiation
    Given "2" agents
      | name | role   |
      | Acme | issuer |
      | Bob  | holder |
    And "Acme" and "Bob" have an existing connection
    And "Acme" offers a credential
    When "Bob" negotiates the offer with a proposal of the credential to "Acme"
    And "Acme" Offers the credential
    And "Bob" requests the credential
    And "Acme" issues the credential
    And "Bob" acknowledges the credential issue
    Then "Bob" has the credential issued

  @T005-RFC0036 @minor @wip @AcceptanceTest
  Scenario: Issue a credential with negotiation beginning from a credential request
    Given "2" agents
      | name | role   |
      | Acme | issuer |
      | Bob  | holder |
    And "Acme" and "Bob" have an existing connection
    When "Bob" requests the credential
    And "Acme" offers a credential
    When "Bob" negotiates the offer with a proposal of the credential to "Acme"
    And "Acme" offers a credential
    And "Acme" issues the credential
    And "Bob" acknowledges the credential issue
    Then "Bob" has the credential issued

  @T006-RFC0036 @critical @wip @AcceptanceTest
  Scenario: Issue a credential with the Holder beginning with a request and is accepted
    Given "2" agents
      | name | role   |
      | Acme | issuer |
      | Bob  | holder |
    And "Acme" and "Bob" have an existing connection
    When "Bob" requests the credential
    And "Acme" issues the credential
    And "Bob" acknowledges the credential issue
    Then "Bob" has the credential issued