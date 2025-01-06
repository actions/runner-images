#include <cosmwasm.hpp>
#include <vector>
#include <string>

// Recipient structure
struct Recipient {
    std::string address;
    uint64_t amount; // Amount in microATOM
};

// Input message
struct ReimburseMsg {
    std::vector<Recipient> recipients;
};

// Main contract logic
class Contract : public cosmwasm::Contract<Contract> {
public:
    // Execute function
    cosmwasm::Response execute(const cosmwasm::MessageInfo& info, const ReimburseMsg& msg) {
        // Verify sender funds
        uint64_t total_amount = 0;
        for (const auto& recipient : msg.recipients) {
            total_amount += recipient.amount;
        }

        uint64_t sent_amount = info.funds.at(0).amount;

        if (sent_amount < total_amount) {
            throw std::runtime_error("Insufficient funds provided");
        }

        // Generate bank send messages
        std::vector<cosmwasm::BankMsg> bank_msgs;
        for (const auto& recipient : msg.recipients) {
            bank_msgs.emplace_back(cosmwasm::BankMsg::Send{
                recipient.address,
                {{ "uatom", recipient.amount }}
            });
        }

        // Create response with messages
        return cosmwasm::Response()
            .add_messages(bank_msgs)
            .add_attribute("action", "reimburse")
            .add_attribute("sender", info.sender);
    }
};
