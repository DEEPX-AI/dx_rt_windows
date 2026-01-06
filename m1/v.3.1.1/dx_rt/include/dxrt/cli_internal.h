/*
 * Copyright (C) 2018- DEEPX Ltd.
 * All rights reserved.
 *
 * This software is the property of DEEPX and is provided exclusively to customers
 * who are supplied with DEEPX NPU (Neural Processing Unit).
 * Unauthorized sharing or usage is strictly prohibited by law.
 *
 * This file uses cxxopts (MIT License) - Copyright (c) 2014 Jarryd Beck.
 */

#pragma once

// C system headers

// C++ standard headers
#include <memory>
#include <string>

// Project headers
#include "dxrt/common.h"
#include "dxrt/cli.h"

namespace dxrt {

class DXRT_API DeviceMonitorDebug : public CLICommand {
 public:
  explicit DeviceMonitorDebug(cxxopts::ParseResult &);
 private:
  void doCommand(std::shared_ptr<DeviceCore> devicePtr) override;
};


class DXRT_API DDRTargetCommand : public CLICommand {
 public:
  explicit DDRTargetCommand(cxxopts::ParseResult &);
 private:
  void doCommand(std::shared_ptr<DeviceCore> devicePtr) override;
};

class DXRT_API OTPCommand : public CLICommand {
 public:
  explicit OTPCommand(cxxopts::ParseResult &);
 private:
  void doCommand(std::shared_ptr<DeviceCore> devicePtr) override;
};


class DXRT_API LedCommand : public CLICommand {
 public:
  explicit LedCommand(cxxopts::ParseResult &);
 private:
  void doCommand(std::shared_ptr<DeviceCore> devicePtr) override;
};

class DXRT_API ModelUploadCommand : public CLICommand {
 public:
  explicit ModelUploadCommand(cxxopts::ParseResult &);
 private:
  void doCommand(std::shared_ptr<DeviceCore> devicePtr) override;
  uint32_t UploadModel(std::shared_ptr<DeviceCore> devicePtr, std::string filePath, uint64_t base_addr);
};

class DXRT_API StartTestCommand : public CLICommand {
 public:
  explicit StartTestCommand(cxxopts::ParseResult &);
 private:
  void doCommand(std::shared_ptr<DeviceCore> devicePtr) override;
};

class DXRT_API FCTCommand : public CLICommand {
 public:
  explicit FCTCommand(cxxopts::ParseResult &);
 private:
  void doCommand(std::shared_ptr<DeviceCore> devicePtr) override;
};

class DXRT_API StartFCTTestCommand : public CLICommand {
 public:
  explicit StartFCTTestCommand(cxxopts::ParseResult &);
 private:
  void doCommand(std::shared_ptr<DeviceCore> devicePtr) override;
};

// Test hook: allow unit tests to inject a custom DevicePool implementation.
// When a test pool is set, CLICommand will NOT initialize the real singleton
// and will enumerate devices from the injected pool instead.
DXRT_API void SetTestDevicePool(DevicePool* p);

}  // namespace dxrt
