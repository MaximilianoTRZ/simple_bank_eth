const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SimpleBank", function () {
  let SimpleBank, simpleBank, owner, user1, user2, contract;

  beforeEach(async function () {
    [owner, user1, user2] = await ethers.getSigners();

    SimpleBank = await ethers.getContractFactory("SimpleBank");
    simpleBank = await SimpleBank.connect(owner).deploy();
  });

  it("should enroll a user", async function () {
    await simpleBank.connect(user1).enroll();
    expect(await simpleBank.enrolled(user1.address)).to.equal(true);
  });

  it("should deposit and update balance correctly", async function () {
    await simpleBank.connect(user1).enroll();
    await simpleBank.connect(user1).deposit({ value: ethers.parseEther("1") });

    const balance = await simpleBank.connect(user1).getBalance();
    expect(balance).to.equal(ethers.parseEther("1"));
  });

  it("should allow only enrolled users to deposit", async function () {
    await expect(
      simpleBank.connect(user1).deposit({ value: ethers.parseEther("1") })
    ).to.be.revertedWith("User not enrolled");
  });

  it("should withdraw correct amount", async function () {
    await simpleBank.connect(user1).enroll();
    await simpleBank.connect(user1).deposit({ value: ethers.parseEther("2") });

    await simpleBank.connect(user1).withdraw(ethers.parseEther("1"));
    const balance = await simpleBank.connect(user1).getBalance();
    expect(balance).to.equal(ethers.parseEther("1"));
  });

  it("should not allow over-withdrawal", async function () {
    await simpleBank.connect(user1).enroll();
    await simpleBank.connect(user1).deposit({ value: ethers.parseEther("1") });

    await expect(
      simpleBank.connect(user1).withdraw(ethers.parseEther("2"))
    ).to.be.revertedWith("Insufficient user funds");
  });
});
