
#include <cosmwasm.hpp>
#include <vector>
#include <string>

// Recipient structure
struct Recipient {
    std::string address;
    uint64_t amount; // Amount in microATOM
};

// Input message structure
struct ReimburseMsg {
    std::vector<Recipient> recipients;
};

// Main contract class
class Contract : public cosmwasm::Contract<Contract> {
public:
    // Execute function
    cosmwasm::Response execute(const cosmwasm::MessageInfo& info, const ReimburseMsg& msg) {
        // Calculate total reimbursement amount
        uint64_t total_amount = 0;
        for (const auto& recipient : msg.recipients) {
            total_amount += recipient.amount;
        }

        // Verify sender has sufficient funds
        uint64_t sent_amount = info.funds.at(0).amount;
        if (sent_amount < total_amount) {
            throw std::runtime_error("Insufficient funds provided");
        }

        // Generate BankMsg::Send for each recipient
        std::vector<cosmwasm::BankMsg> bank_msgs;
        for (const auto& recipient : msg.recipients) {
            bank_msgs.emplace_back(cosmwasm::BankMsg::Send{
                recipient.address,
                {{ "uatom", recipient.amount }}
            });
        }

        // Return response with messages and attributes
        return cosmwasm::Response()
            .add_messages(bank_msgs)
            .add_attribute("action", "reimburse")
            .add_attribute("sender", info.sender);
    }
};
